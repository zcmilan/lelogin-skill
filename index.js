import { readFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
export const name = 'lelogin-skill';
export const inject = ['skills'];
const root = dirname(fileURLToPath(import.meta.url));
const skillRoot = join(root, 'skills', 'lelogin');
function readSkill() {
    const content = readFileSync(join(skillRoot, 'SKILL.md'), 'utf8');
    const descriptionMatch = content.match(/^description:\s*(.+)$/m);
    return {
        name: 'lelogin',
        description: descriptionMatch?.[1]?.trim() ?? 'Use LeLogin CLI and Workspace without exposing plaintext secrets.',
        content,
        source: 'bundled:@lelogin/dsh-plugin',
        resourceBase: { kind: 'directory', path: skillRoot }
    };
}
export function apply(ctx) {
    return ctx.skills.register(readSkill());
}
