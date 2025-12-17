// MCP 组件统一导出
export { default as ChatComponent } from './ChatComponent.vue'
export { default as ThinkingComponent } from './ThinkingComponent.vue'
export { default as MemoryComponent } from './MemoryComponent.vue'
export { default as TerminalComponent } from './TerminalComponent.vue'
export { default as McpToolComponent } from './McpToolComponent.vue'
export { default as AttemptCompletionComponent } from './AttemptCompletionComponent.vue'
export { default as AskFollowupQuestionComponent } from './AskFollowupQuestionComponent.vue'
export { default as StepComponent } from './StepComponent.vue'
export { default as FileComponent } from './FileComponent.vue'
export { default as FileOperationComponent } from './FileOperationComponent.vue'
export { default as ExecuteComponent } from './ExecuteComponent.vue'
export { default as ReadFileComponent } from './ReadFileComponent.vue'
export { default as ReplaceInFileComponent } from './ReplaceInFileComponent.vue'
export { default as SearchFilesComponent } from './SearchFilesComponent.vue'
export { default as WriteToFileComponent } from './WriteToFileComponent.vue'
export { default as ListFilesComponent } from './ListFilesComponent.vue'
export { default as ListCodeDefinitionNamesComponent } from './ListCodeDefinitionNamesComponent.vue'
export { default as ExecuteCommandComponent } from './ExecuteCommandComponent.vue'
export { default as ToolResultComponent } from './ToolResultComponent.vue'
export { default as PidComponent } from './PidComponent.vue'
export { default as TerminalAppendComponent } from './TerminalAppendComponent.vue'
export { default as NotificationComponent } from './NotificationComponent.vue'
export { default as DownloadFileComponent } from './DownloadFileComponent.vue'
export { default as HiveMsgIdComponent } from './HiveMsgIdComponent.vue'
export { default as TextComponent } from './TextComponent.vue'
export { default as MessageComponent } from './MessageComponent.vue'

// 组件映射表
import ChatComponent from './ChatComponent.vue'
import ThinkingComponent from './ThinkingComponent.vue'
import MemoryComponent from './MemoryComponent.vue'
import TerminalComponent from './TerminalComponent.vue'
import McpToolComponent from './McpToolComponent.vue'
import AttemptCompletionComponent from './AttemptCompletionComponent.vue'
import AskFollowupQuestionComponent from './AskFollowupQuestionComponent.vue'
import StepComponent from './StepComponent.vue'
import FileComponent from './FileComponent.vue'
import FileOperationComponent from './FileOperationComponent.vue'
import ExecuteComponent from './ExecuteComponent.vue'
import ReadFileComponent from './ReadFileComponent.vue'
import ReplaceInFileComponent from './ReplaceInFileComponent.vue'
import SearchFilesComponent from './SearchFilesComponent.vue'
import WriteToFileComponent from './WriteToFileComponent.vue'
import ListFilesComponent from './ListFilesComponent.vue'
import ListCodeDefinitionNamesComponent from './ListCodeDefinitionNamesComponent.vue'
import ExecuteCommandComponent from './ExecuteCommandComponent.vue'
import ToolResultComponent from './ToolResultComponent.vue'
import PidComponent from './PidComponent.vue'
import TerminalAppendComponent from './TerminalAppendComponent.vue'
import NotificationComponent from './NotificationComponent.vue'
import DownloadFileComponent from './DownloadFileComponent.vue'
import HiveMsgIdComponent from './HiveMsgIdComponent.vue'
import TextComponent from './TextComponent.vue'
import MessageComponent from './MessageComponent.vue'

export const componentMap: Record<string, any> = {
  'chat': ChatComponent,
  'thinking': ThinkingComponent,
  'memory': MemoryComponent,
  'terminal': TerminalComponent,
  'use_mcp_tool': McpToolComponent,
  'attempt_completion': AttemptCompletionComponent,
  'ask_followup_question': AskFollowupQuestionComponent,
  'step': StepComponent,
  'file': FileComponent,
  'file_operation': FileOperationComponent,
  'execute': ExecuteComponent,
  'read_file': ReadFileComponent,
  'replace_in_file': ReplaceInFileComponent,
  'search_files': SearchFilesComponent,
  'write_to_file': WriteToFileComponent,
  'list_files': ListFilesComponent,
  'list_code_definition_names': ListCodeDefinitionNamesComponent,
  'execute_command': ExecuteCommandComponent,
  'tool_result': ToolResultComponent,
  'pid': PidComponent,
  'terminal_append': TerminalAppendComponent,
  'notification': NotificationComponent,
  'download_file': DownloadFileComponent,
  'hive-msg-id': HiveMsgIdComponent,
  'text': TextComponent,
  'message': MessageComponent,
}
