-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.isHermCol_diagCol
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℕ → ℝ) : IsHermCol (diagCol lam) := by

  intro j k
  classical
  rcases eq_or_ne j k with h | h
  · subst h
    simp [diagCol]
  · rw [diagCol, diagCol, Finsupp.single_apply, Finsupp.single_apply, if_neg h.symm,
      if_neg h, map_zero]
