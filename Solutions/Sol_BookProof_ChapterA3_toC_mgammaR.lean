-- Generated from ChapterA3c.lean — solution of BookProof.ChapterA3.toC_mgammaR
import Mathlib
import Definitions.Def_ChapterA3c
open BookProof.ChapterA3



open Matrix
open scoped ComplexConjugate

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) : toC (mgammaR μ) = mgamma μ := by

  unfold toC mgammaR mgamma; ext i j; fin_cases μ <;> fin_cases i <;> fin_cases j <;> rfl;
