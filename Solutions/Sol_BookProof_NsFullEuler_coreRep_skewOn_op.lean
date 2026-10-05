-- Generated from ChapterNsFourierElimination.lean — solution of BookProof.NsFullEuler.coreRep_skewOn_op
import Mathlib
import Definitions.Def_ChapterNsFourierElimination
import Theorems.Thm_BookProof_HermiteProductCore_gaussInt_smul
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_symm
import Theorems.Thm_BookProof_YangMillsHermite_inner_pgLp_pgLp
open BookProof.NsFullEuler




open MvPolynomial
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension
open BookProof.HermiteProductCore BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.QgOuterFock BookProof.StoneBridge BookProof.QgOuterFockFL

noncomputable section

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (Φ : CoreRep d D) {T : Module.End ℂ (MvPolynomial (Fin d) ℂ)}
    (hT : PolySkew T) (x y : D) :
    inner ℂ ((D.subtype.comp (Φ.op T)) x) ((y : D) : L2d d)
      = -inner ℂ ((x : D) : L2d d) ((D.subtype.comp (Φ.op T)) y) := by

  have hx : (D.subtype.comp (Φ.op T)) x = pgLp (T (Φ.equiv.symm x)) := Φ.coe_op T x
  have hy : (D.subtype.comp (Φ.op T)) y = pgLp (T (Φ.equiv.symm y)) := Φ.coe_op T y
  have hcx : ((x : D) : L2d d) = pgLp (Φ.equiv.symm x) := Φ.coe_symm x
  have hcy : ((y : D) : L2d d) = pgLp (Φ.equiv.symm y) := Φ.coe_symm y
  have hneg : ∀ z : MvPolynomial (Fin d) ℂ, gaussInt (-z) = -gaussInt z := by
    intro z
    rw [show (-z) = (-1 : ℂ) • z by module, gaussInt_smul]
    ring
  have h := hT (Φ.equiv.symm x) (Φ.equiv.symm y)
  simp only [LinearMap.neg_apply, mul_neg, hneg] at h
  rw [hx, hy, hcx, hcy, inner_pgLp_pgLp, inner_pgLp_pgLp]
  exact h
