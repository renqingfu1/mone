import { SimpleHtmlParser } from "../plugins/simple-html-parser";

// JSON 结构定义
export interface ComponentNode {
  type: string;
  props?: Record<string, any>;
  children?: ComponentNode[];
  text?: string;
}

/**
 * 解析 XML 内容并转换为组件 JSON 数据
 * 完全独立，不依赖 MarkdownIt
 * 支持所有 MCP 标签
 */
export function parseXmlToComponents(xmlContent: string): ComponentNode[] {
  const components: ComponentNode[] = [];
  const componentStack: ComponentNode[] = [];
  
  // 用于收集各种标签内容的变量
  const tagData: Record<string, any> = {};
  
  // 辅助函数
  const createComponentNode = (type: string, props?: Record<string, any>): ComponentNode => {
    return { type, props: props || {}, children: [] };
  };

  const getCurrentComponent = () => componentStack[componentStack.length - 1];

  const parser = new SimpleHtmlParser({
    onopentag(name, attributes) {
      const node = createComponentNode(name, { ...attributes });
        
        // 初始化标签数据收集
        tagData[name] = {
          text: '',
          message: '',
          serverName: '',
          toolName: '',
          arguments: '',
          result: '',
          command: '',
          question: '',
          pid: '',
          content: '',
          msgId: '',
          fileName: attributes.fileName || '',
          fileUrl: attributes.fileUrl || ''
        };
        
        if (componentStack.length > 0) {
          getCurrentComponent().children!.push(node);
        } else {
          components.push(node);
        }
        componentStack.push(node);
    },
    ontext(text) {
      const currentComponent = getCurrentComponent();
      if (!currentComponent) return;
      
      const tagName = currentComponent.type;
      
      // 根据不同的标签类型收集内容
      if (tagName === 'chat') {
        // chat 标签内的 message 内容需要特殊处理
        if (!tagData[tagName]) tagData[tagName] = { message: '' };
        // message 标签的内容会在 onclosetag 中处理
      } else if (tagName === 'message' && componentStack.length > 1) {
        // message 在 chat 内部
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'chat') {
          if (!tagData['chat']) tagData['chat'] = { message: '' };
          tagData['chat'].message += text;
        }
      } else if (tagName === 'server_name' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'use_mcp_tool') {
          if (!tagData['use_mcp_tool']) tagData['use_mcp_tool'] = { serverName: '' };
          tagData['use_mcp_tool'].serverName += text;
        }
      } else if (tagName === 'tool_name' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'use_mcp_tool') {
          if (!tagData['use_mcp_tool']) tagData['use_mcp_tool'] = { toolName: '' };
          tagData['use_mcp_tool'].toolName += text;
        }
      } else if (tagName === 'arguments' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'use_mcp_tool') {
          if (!tagData['use_mcp_tool']) tagData['use_mcp_tool'] = { arguments: '' };
          tagData['use_mcp_tool'].arguments += text;
        }
      } else if (tagName === 'result' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'attempt_completion') {
          if (!tagData['attempt_completion']) tagData['attempt_completion'] = { result: '' };
          tagData['attempt_completion'].result += text;
        }
      } else if (tagName === 'command' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'attempt_completion') {
          if (!tagData['attempt_completion']) tagData['attempt_completion'] = { command: '' };
          tagData['attempt_completion'].command += text;
        }
      } else if (tagName === 'question' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'ask_followup_question') {
          if (!tagData['ask_followup_question']) tagData['ask_followup_question'] = { question: '' };
          tagData['ask_followup_question'].question += text;
        }
      } else if (tagName === 'pid') {
        if (!tagData['pid']) tagData['pid'] = { pid: '' };
        tagData['pid'].pid += text;
      } else if (tagName === 'process_pid' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'terminal_append') {
          if (!tagData['terminal_append']) tagData['terminal_append'] = { pid: '' };
          tagData['terminal_append'].pid += text;
        }
      } else if (tagName === 'process_content' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'terminal_append') {
          if (!tagData['terminal_append']) tagData['terminal_append'] = { content: '' };
          tagData['terminal_append'].content += text;
        }
      } else if (tagName === 'hive-msg-id') {
        if (!tagData['hive-msg-id']) tagData['hive-msg-id'] = { msgId: '' };
        tagData['hive-msg-id'].msgId += text;
      } else if (tagName === 'notification') {
        if (!tagData['notification']) tagData['notification'] = { content: '' };
        tagData['notification'].content += text;
      } else {
        // 其他标签直接收集文本
        if (!tagData[tagName]) tagData[tagName] = { text: '' };
        tagData[tagName].text += text;
      }
    },
    onclosetag(tagname) {
      const component = componentStack.pop();
        if (component && tagData[tagname]) {
          const data = tagData[tagname];
          
          // 确保 props 存在
          if (!component.props) {
            component.props = {};
          }
          
          // 根据标签类型设置对应的 props
          if (tagname === 'chat') {
            component.props.message = data.message?.trim() || '';
          } else if (tagname === 'use_mcp_tool') {
            component.props.serverName = data.serverName?.trim() || '';
            component.props.toolName = data.toolName?.trim() || '';
            component.props.arguments = data.arguments?.trim() || '';
          } else if (tagname === 'attempt_completion') {
            component.props.result = data.result?.trim() || '';
            component.props.command = data.command?.trim() || '';
          } else if (tagname === 'ask_followup_question') {
            component.props.question = data.question?.trim() || '';
          } else if (tagname === 'pid') {
            component.props.pid = data.pid?.trim() || '';
          } else if (tagname === 'terminal_append') {
            component.props.pid = data.pid?.trim() || '';
            component.props.content = data.content?.trim() || '';
          } else if (tagname === 'hive-msg-id') {
            component.props.msgId = data.msgId?.trim() || '';
          } else if (tagname === 'notification') {
            component.props.content = data.content?.trim() || '';
          } else {
            component.text = data.text?.trim() || '';
          }
          
          // 清理数据
          delete tagData[tagname];
        }
    },
  });

  parser.write(xmlContent);
  parser.end();

  return components;
}

/**
 * 从文本中提取 XML 组件并转换为 JSON
 * 支持所有 MCP 标签
 */
export function extractComponentsFromText(text: string): ComponentNode[] {
  return parseXmlToComponents(text);
}

/**
 * 将组件 JSON 数据编码为 base64 字符串
 */
export function encodeComponents(components: ComponentNode[]): string {
  if (components.length === 0) {
    return "";
  }
  const jsonData = JSON.stringify(components);
  return btoa(unescape(encodeURIComponent(jsonData)));
}

/**
 * 解码 base64 字符串为组件 JSON 数据
 */
export function decodeComponents(encodedData: string): ComponentNode[] {
  try {
    const jsonData = decodeURIComponent(escape(atob(encodedData)));
    return JSON.parse(jsonData);
  } catch (e) {
    console.error('Failed to decode components:', e);
    return [];
  }
}
