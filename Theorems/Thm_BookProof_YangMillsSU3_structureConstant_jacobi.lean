-- Generated from ChapterYangMillsSU3.lean — theorem BookProof.YangMillsSU3.structureConstant_jacobi
import Mathlib
import Definitions.Def_ChapterYangMillsSU3
open BookProof.YangMillsSU3







open Matrix BigOperators


variable {n d : ℕ}
variable (T : Fin d → Matrix (Fin n) (Fin n) ℂ)
variable (f : Fin d → Fin d → Fin d → ℝ)



variable {T f}

theorem BookProof.YangMillsSU3.structureConstant_jacobi
    (hT : TraceOrthonormal T) (hf : ClosesWithStructureConstants T f)
    (a b c h : Fin d) :
    ∑ e, (f a b e * f e c h + f b c e * f e a h + f c a e * f e b h) = 0 := by sorry
