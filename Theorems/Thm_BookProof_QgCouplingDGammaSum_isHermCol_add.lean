-- Generated from ChapterQgCouplingDGammaSum.lean — theorem BookProof.QgCouplingDGammaSum.isHermCol_add
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum

variable {ι : Type*}



open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

theorem BookProof.QgCouplingDGammaSum.isHermCol_add {a b : ℕ → (ℕ →₀ ℂ)} (ha : IsHermCol a) (hb : IsHermCol b) :
    IsHermCol (fun k => a k + b k) := by sorry
