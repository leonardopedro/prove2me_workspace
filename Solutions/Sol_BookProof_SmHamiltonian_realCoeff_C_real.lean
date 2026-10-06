-- Generated from ChapterSmHamiltonian.lean — solution of BookProof.SmHamiltonian.realCoeff_C_real
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Theorems.Thm_BookProof_YangMillsHermite_starP_C
open BookProof.SmHamiltonian




open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {d : ℕ} (t : ℝ) :
    RealCoeff (C ((t : ℝ) : ℂ) : MvPolynomial (Fin d) ℂ) := by

  change starP (C ((t : ℝ) : ℂ)) = C ((t : ℝ) : ℂ)
  rw [starP_C, Complex.conj_ofReal]
