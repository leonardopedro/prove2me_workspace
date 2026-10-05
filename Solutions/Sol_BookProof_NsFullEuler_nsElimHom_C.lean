-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.nsElimHom_C
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : Fin 3 → ℝ) (n : ℕ) (c : ℂ) :
    nsElimHom k n (C c : MvPolynomial (Fin (n * 21)) ℂ)
      = (C c : MvPolynomial (Fin (n * 6)) ℂ) := MvPolynomial.eval₂Hom_C _ _ c
