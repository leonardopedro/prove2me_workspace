-- Generated from ChapterQgCouplingDGammaSum.lean — solution of BookProof.QgCouplingDGammaSum.isHermCol_add
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
theorem solution {a b : ℕ → (ℕ →₀ ℂ)} (ha : IsHermCol a) (hb : IsHermCol b) :
    IsHermCol (fun k => a k + b k) := by

  intro j k
  simp only [Finsupp.add_apply, map_add]
  rw [ha j k, hb j k]
