-- Generated from ChapterSmHamiltonian.lean — solution of BookProof.SmHamiltonian.wall_sq
import Mathlib
import Definitions.Def_ChapterSmHamiltonian
import Theorems.Thm_BookProof_NsLagrangianDetFL_lam_nonneg
open BookProof.SmHamiltonian




open MvPolynomial
open BookProof.SmOneParticle
open BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.HermiteProductCore BookProof.FarisLavine
open BookProof.FriedrichsExtension

noncomputable section

variable {D : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) (q : ℝ) :
    1 / 2 * (Real.sqrt (P.lam / 2) * (q - P.vev ^ 2)) ^ 2
      = P.lam / 4 * (q - P.vev ^ 2) ^ 2 := by

  have hs : Real.sqrt (P.lam / 2) ^ 2 = P.lam / 2 :=
    Real.sq_sqrt (by linarith [P.lam_nonneg])
  nlinarith [hs]
