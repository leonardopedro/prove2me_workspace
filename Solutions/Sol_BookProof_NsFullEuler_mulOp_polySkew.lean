-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.mulOp_polySkew
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_apply
import Theorems.Thm_BookProof_YangMillsHermite_starP_C
import Theorems.Thm_BookProof_YangMillsHermite_starP_mul
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgOuterFockEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterQgOuterFockFarisLavine
import Definitions.Def_ChapterF7
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterNavierStokesFullEulerianFock
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL
open BookProof.ChapterF7
open BookProof.HermiteProductCore
open BookProof.YangMillsHermite

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {f : MvPolynomial (Fin d) ℂ} (hf : RealCoeff f) :
    PolySkew (mulOp (C Complex.I * f)) := by

  intro p q
  have hL : starP ((C Complex.I * f) * p) * q
      = (-(C Complex.I * f)) * (starP p * q) := by
    simp only [starP_mul, starP_C, Complex.conj_I, show starP f = f from hf, C_neg]
    ring
  have hR : starP p * ((-mulOp (C Complex.I * f)) q) = (-(C Complex.I * f)) * (starP p * q) := by
    simp only [mulOp_apply, LinearMap.neg_apply, neg_mul]
    ring
  change gaussInt (starP ((mulOp (C Complex.I * f)) p) * q)
      = gaussInt (starP p * (-(mulOp (C Complex.I * f))) q)
  rw [mulOp_apply, hL, hR]
