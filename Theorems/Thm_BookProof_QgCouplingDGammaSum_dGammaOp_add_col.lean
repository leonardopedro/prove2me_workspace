-- Generated from ChapterQgCouplingDGammaSum.lean — theorem BookProof.QgCouplingDGammaSum.dGammaOp_add_col
import Mathlib
import Definitions.Def_ChapterQgCouplingDGammaSum
open BookProof.QgCouplingDGammaSum

variable {ι : Type*}



open BookProof.FockSecondQuantization
open BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.FarisLavine BookProof.FriedrichsExtension BookProof.YangMillsFriedrichs

noncomputable section

variable {ι : Type*}

theorem BookProof.QgCouplingDGammaSum.dGammaOp_add_col (a b : ℕ → (ℕ →₀ ℂ)) (x : lpFiniteModes Conf) :
    dGammaOp (fun k => a k + b k) x = dGammaOp a x + dGammaOp b x := by sorry
