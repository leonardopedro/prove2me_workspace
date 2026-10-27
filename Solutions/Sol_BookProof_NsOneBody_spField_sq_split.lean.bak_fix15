-- Generated from ChapterNsOneBodyDGamma.lean — solution of BookProof.NsOneBody.spField_sq_split
import Mathlib
import Definitions.Def_ChapterNsOneBodyDGamma
open BookProof.NsOneBody




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.QgOuterFockFL
open BookProof.NsFullEuler BookProof.FockSecondQuantization BookProof.FockSchur
open BookProof.HermiteGalerkin BookProof.NavierStokesFlow BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.EsaClosure

noncomputable section

variable {D : Submodule ℂ (L2d 6)}

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep 6 D) (nu : ℝ) (k : Fin 3 → ℝ) (r : Fin 7) :
    (spField Φ nu k r).comp (spField Φ nu k r)
      = (spFieldVisc Φ nu k r).comp (spFieldVisc Φ nu k r)
        + (spFieldAdv Φ nu k r).comp (spFieldAdv Φ nu k r) := by

  simp only [spFieldVisc, spFieldAdv]
  split <;> simp
