-- Generated from ChapterA3i.lean — solution of BookProof.ChapterA3.sigmaZ_mul_transpose
import Mathlib
import Definitions.Def_ChapterA3i
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution :
    SigmaZ * SigmaZᵀ = (2 : ℤ) • (1 : Matrix (Fin 4) (Fin 4) ℤ) := by

  decide
