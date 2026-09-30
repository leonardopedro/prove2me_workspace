-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.JacobiDeficiency.jacobiOp_not_hasZeroDeficiencyOn
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_defState_ne_zero
import Theorems.Thm_BookProof_NavierStokesFlow_JacobiDeficiency_defState_deficiency
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.JacobiDeficiency










open scoped ENNReal











open LpNat

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ HasZeroDeficiencyOn (lpFiniteModes ℕ) jacobiOp := by

  intro hzero
  exact defState_ne_zero (hzero.1 defState fun v => defState_deficiency v)
