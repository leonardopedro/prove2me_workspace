-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.commForm_kvnGen_mul_bound
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
import Theorems.Thm_BookProof_KoopmanLyapunov_quadForm_mulCoreOp
import Theorems.Thm_BookProof_KoopmanLyapunov_commForm_kvnGen_mul
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine
open BookProof.NsKoopman

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {G : Fin d → MvPolynomial (Fin d) ℂ}
    (hG : ∀ i, RealCoeff (G i)) {E : MvPolynomial (Fin d) ℂ} (hE : RealCoeff E) {c : ℝ}
    (hflux : ∀ y : Vd d, |(MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ))
      (∑ i, G i * pderiv i E)).re| ≤ c * (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) E).re)
    (x : polyGaussCore (d := d)) :
    |commForm (kvnGenOp G) (mulCoreOp E) x| ≤ c * quadForm (mulCoreOp E) x := by

  set p := (coreRepPoly d).equiv.symm x with hp
  set Φ := ∑ i, G i * pderiv i E with hΦ
  have hscal : ∀ t : ℝ, (gpair p ((((t : ℝ) : ℂ) • E) * p)).re = t * (gpair p (E * p)).re := by
    intro t
    rw [smul_mul_assoc, gpair_smul_right]
    simp
  have hev : ∀ (t : ℝ) (y : Vd d), (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ))
      (((t : ℝ) : ℂ) • E)).re = t * (MvPolynomial.eval (fun i => ((y i : ℝ) : ℂ)) E).re := by
    intro t y
    rw [MvPolynomial.smul_eq_C_mul, map_mul, MvPolynomial.eval_C, Complex.re_ofReal_mul]
  rw [commForm_kvnGen_mul hG hE, quadForm_mulCoreOp, abs_le]
  constructor
  · have := gpair_mul_mono (g := ((-c : ℝ) : ℂ) • E) (s := Φ) (fun y => by
      rw [hev]; have := (abs_le.mp (hflux y)).1; linarith) p
    rw [hscal] at this
    linarith
  · have := gpair_mul_mono (g := Φ) (s := ((c : ℝ) : ℂ) • E) (fun y => by
      rw [hev]; exact (abs_le.mp (hflux y)).2) p
    rw [hscal] at this
    linarith
