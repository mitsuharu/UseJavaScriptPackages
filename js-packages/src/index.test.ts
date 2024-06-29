import { Bridge } from './index'; // 適切なパスに変更してください

describe('Bridge', () => {
    
    /**
     * mean のテスト
     */
    describe('mean', () => {
        it('should return the mean of an array of numbers', () => {
            const array = [1, 2, 3, 4, 5];
            const result = Bridge.mean(array);
            expect(result).toBe(3);
        });
    
        it('should throw an error for an empty array', () => {
            const array: number[] = [];
            expect(() => Bridge.mean(array)).toThrow();
        });
    
        it('should return the correct mean for a single element array', () => {
            const array = [10];
            const result = Bridge.mean(array);
            expect(result).toBe(10);
        });
    
        it('should handle negative numbers', () => {
            const array = [-1, -2, -3, -4, -5];
            const result = Bridge.mean(array);
            expect(result).toBe(-3);
        });
    });
});
