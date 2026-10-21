-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.occEnergy_nonneg
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum




open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

variable {ι : Type*}

set_option maxHeartbeats 1000000 in
theorem solution {lam : ℕ → ℝ} (hlam : ∀ k, 0 ≤ lam k) (α : Conf) :
    0 ≤ occEnergy lam α := Finset.sum_nonneg fun k _ => mul_nonneg (hlam k) (Nat.cast_nonneg _)
