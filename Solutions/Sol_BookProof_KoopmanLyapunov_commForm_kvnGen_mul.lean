-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.commForm_kvnGen_mul
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_KoopmanLyapunov_kvnGen_polySym
import Theorems.Thm_BookProof_KoopmanLyapunov_kvnGen_comm_mul
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
import Theorems.Thm_BookProof_YangMillsHermite_mulOp_polySym
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {G : Fin d → MvPolynomial (Fin d) ℂ} (hG : ∀ i, RealCoeff (G i))
    {E : MvPolynomial (Fin d) ℂ} (hE : RealCoeff E) (x : polyGaussCore (d := d)) :
    commForm (kvnGenOp G) (mulCoreOp E) x
      = (gpair ((coreRepPoly d).equiv.symm x)
          ((∑ i, G i * pderiv i E) * (coreRepPoly d).equiv.symm x)).re := by

  set p := (coreRepPoly d).equiv.symm x with hp
  have hH : (kvnGenOp G) x = pgLp (kvnGen G p) := (coreRepPoly d).coe_op (kvnGen G) x
  have hN : mulCoreOp E x = pgLp (E * p) := (coreRepPoly d).coe_op (mulOp E) x
  have h1 : (inner ℂ ((kvnGenOp G) x) (mulCoreOp E x) : ℂ)
      = gpair p (kvnGen G (E * p)) := by
    rw [hH, hN, ← gpair_eq_inner]
    exact kvnGen_polySym hG p (E * p)
  have h2 : (inner ℂ (mulCoreOp E x) ((kvnGenOp G) x) : ℂ)
      = gpair p (E * kvnGen G p) := by
    rw [hH, hN, ← gpair_eq_inner]
    exact mulOp_polySym hE p (kvnGen G p)
  rw [commForm, h1, h2, ← gpair_sub_right, kvnGen_comm_mul, gpair_smul_right]
  simp [Complex.mul_re, Complex.mul_im]
