-- Generated from ChapterKoopmanLyapunovFarisLavine.lean — solution of BookProof.KoopmanLyapunov.kvnGen_apply
import Mathlib
import Definitions.Def_ChapterKoopmanLyapunovFarisLavine
open BookProof.KoopmanLyapunov




open MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite BookProof.FarisLavine

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (G : Fin d → MvPolynomial (Fin d) ℂ) (p : MvPolynomial (Fin d) ℂ) :
    kvnGen G p = (-Complex.I) • ((∑ i, G i * derOp i p)
      + ((1 / 2 : ℝ) : ℂ) • ((∑ i, pderiv i (G i)) * p)) := by

  have hsum : kvnGen G p = ∑ i, weylProd (momOp i) (mulOp (G i)) p := by
    rw [kvnGen]; simp
  rw [hsum, Finset.sum_congr rfl fun i _ => weylProd_mom_mul_apply (G i) p i,
    ← Finset.smul_sum, Finset.sum_add_distrib, ← Finset.smul_sum, ← Finset.sum_mul]
