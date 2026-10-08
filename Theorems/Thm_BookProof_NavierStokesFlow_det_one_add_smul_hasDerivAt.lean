-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.det_one_add_smul_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]

theorem BookProof.NavierStokesFlow.det_one_add_smul_hasDerivAt (A : Matrix (Fin 3) (Fin 3) ℝ) :
    HasDerivAt (fun t : ℝ => (1 + t • A).det) A.trace 0 := by sorry
