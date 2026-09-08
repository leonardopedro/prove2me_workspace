-- Generated from ChapterYangMillsSU3.lean — solution of BookProof.YangMillsSU3.structureConstant_totally_antisymmetric
import Mathlib
import Definitions.Def_ChapterYangMillsSU3
import Theorems.Thm_BookProof_YangMillsSU3_structureConstant_antisymm_swap
import Theorems.Thm_BookProof_YangMillsSU3_structureConstant_antisymm_rotate
open BookProof.YangMillsSU3








open Matrix BigOperators


variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)



variable {T f}

set_option maxHeartbeats 1000000 in
theorem solution
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f) :
    (∀ a b c, f a b c = - f b a c) ∧ (∀ a b c, f a b c = - f a c b) := ⟨structureConstant_antisymm_swap hT hf, structureConstant_antisymm_rotate hT hf⟩
