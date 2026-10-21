-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.ccHamS_symmetricOn
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_DegSchrodinger_kinCcS_symmetricOn
import Theorems.Thm_BookProof_ScalaronEsa_smoothPotential_symmetric
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hW : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (S : Finset (Fin d)) : SymmetricOn (ccDomain (Vd d)) (ccHamS W hW S) := by

  intro x y
  have h1 := kinCcS_symmetricOn S x y
  have h2 := smoothPotential_symmetric W hW x y
  simp only [ccHamS, LinearMap.add_apply, inner_add_left, inner_add_right]
  linear_combination h1 + h2
