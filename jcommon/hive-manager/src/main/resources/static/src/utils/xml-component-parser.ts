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
          serverName: '',
          toolName: '',
          arguments: '',
          result: '',
          command: '',
          question: '',
          pid: '',
          processPid: '',
          processContent: '',
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
      
      // 如果文本在标签外（没有当前组件），创建文本节点
      if (!currentComponent) {
        // 保留所有文本，包括空白字符
        if (text && text.trim()) {
          components.push({
            type: 'text',
            text: text
          });
        }
        return;
      }
      
      const tagName = currentComponent.type;
      
      // 根据不同的标签类型收集内容
      if (tagName === 'server_name' && componentStack.length > 1) {
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
      } else if (tagName === 'process_pid' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'pid') {
          // pid 标签内的 process_pid
          if (!tagData['pid']) tagData['pid'] = { processPid: '', processContent: '' };
          tagData['pid'].processPid += text;
        } else if (parent && parent.type === 'terminal_append') {
          if (!tagData['terminal_append']) tagData['terminal_append'] = { pid: '' };
          tagData['terminal_append'].pid += text;
        }
      } else if (tagName === 'process_content' && componentStack.length > 1) {
        const parent = componentStack[componentStack.length - 2];
        if (parent && parent.type === 'pid') {
          // pid 标签内的 process_content
          if (!tagData['pid']) tagData['pid'] = { processPid: '', processContent: '' };
          tagData['pid'].processContent += text;
        } else if (parent && parent.type === 'terminal_append') {
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
          if (tagname === 'use_mcp_tool') {
            component.props.serverName = data.serverName?.trim() || '';
            component.props.toolName = data.toolName?.trim() || '';
            component.props.arguments = data.arguments?.trim() || '';
          } else if (tagname === 'attempt_completion') {
            component.props.result = data.result?.trim() || '';
            component.props.command = data.command?.trim() || '';
          } else if (tagname === 'ask_followup_question') {
            component.props.question = data.question?.trim() || '';
          } else if (tagname === 'pid') {
            component.props.processPid = data.processPid?.trim() || '';
            component.props.processContent = data.processContent?.trim() || '';
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

  // 合并相同 process_pid 的 pid 组件
  return mergePidComponents(components);
}

/**
 * 合并相同 process_pid 的 pid 组件
 * 将所有相同 process_pid 的 process_content 合并到一个 pid 组件中
 */
function mergePidComponents(components: ComponentNode[]): ComponentNode[] {
  // 收集所有 pid 组件，按 process_pid 分组
  const pidMap = new Map<string, ComponentNode[]>();
  
  // 递归收集所有 pid 组件
  const collectPidComponents = (nodes: ComponentNode[]) => {
    for (const node of nodes) {
      if (node.type === 'pid' && node.props?.processPid) {
        const processPid = node.props.processPid;
        if (!pidMap.has(processPid)) {
          pidMap.set(processPid, []);
        }
        pidMap.get(processPid)!.push(node);
      }
      
      // 递归处理子节点
      if (node.children && node.children.length > 0) {
        collectPidComponents(node.children);
      }
    }
  };
  
  collectPidComponents(components);
  
  // 合并相同 process_pid 的组件
  pidMap.forEach((pidNodes, processPid) => {
    if (pidNodes.length <= 1) {
      return; // 只有一个，不需要合并
    }
    
    // 合并所有 process_content
    const mergedContent = pidNodes
      .map(node => node.props?.processContent || '')
      .filter(content => content.trim())
      .join('\n');
    
    // 更新第一个组件的 process_content
    const firstNode = pidNodes[0];
    if (firstNode.props) {
      firstNode.props.processContent = mergedContent;
    }
    
    // 标记其他节点为待删除
    for (let i = 1; i < pidNodes.length; i++) {
      pidNodes[i].type = '__DELETE__';
    }
  });
  
  // 递归删除标记为 __DELETE__ 的组件
  const removeDeletedComponents = (nodes: ComponentNode[]): ComponentNode[] => {
    const result: ComponentNode[] = [];
    
    for (const node of nodes) {
      if (node.type === '__DELETE__') {
        continue; // 跳过待删除的节点
      }
      
      if (node.children && node.children.length > 0) {
        node.children = removeDeletedComponents(node.children);
      }
      
      result.push(node);
    }
    
    return result;
  };
  
  return removeDeletedComponents(components);
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
