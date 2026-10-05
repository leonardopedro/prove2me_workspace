-- Generated from ChapterSmCarContinuum.lean — solution of BookProof.SmCarContinuum.cAnnS_sub
import Mathlib
import Definitions.Def_ChapterSmCarContinuum
import Theorems.Thm_BookProof_SmCarContinuum_cCreS_sub
open BookProof.SmCarContinuum




open BookProof.QuantumGravityFock
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.LpNat
open BookProof.NavierStokesFlow.IkebeKato
open scoped ENNReal NNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (f g : Ell2) : cAnnS (f - g) = cAnnS f - cAnnS g := by

  simp only [cAnnS, cCreS_sub, map_sub]
