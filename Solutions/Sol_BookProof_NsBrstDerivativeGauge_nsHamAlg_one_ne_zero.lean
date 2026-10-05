-- Generated from ChapterNsBrstDerivativeGauge.lean — solution of BookProof.NsBrstDerivativeGauge.nsHamAlg_one_ne_zero
import Mathlib
import Definitions.Def_ChapterNsBrstDerivativeGauge
import Theorems.Thm_BookProof_NsBrstDerivativeGauge_nsHamAlg_one
open BookProof.NsBrstDerivativeGauge




open MvPolynomial BookProof.BRSTNilpotent BookProof.QuantumGravityBrstCharge
open BookProof.NavierStokesGaugeY BookProof.NavierStokesGaugeY2

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (nu : ℂ) : nsHamAlg nu 1 ≠ 0 := by

  rw [nsHamAlg_one]
  intro h
  have hc := congrArg (MvPolynomial.coeff (Finsupp.single (NSVar.uD 0 0) 1)) h
  rw [MvPolynomial.coeff_sum] at hc
  rw [Finset.sum_eq_single (0 : Fin 3), MvPolynomial.coeff_X] at hc
  simp at hc
  · intro b _ hb
    rw [MvPolynomial.coeff_X']
    exact if_neg fun hh => hb (by
      have := (Finsupp.single_left_injective (by norm_num) hh)
      simpa using this)
  · intro h0
    exact absurd (Finset.mem_univ (0 : Fin 3)) h0
