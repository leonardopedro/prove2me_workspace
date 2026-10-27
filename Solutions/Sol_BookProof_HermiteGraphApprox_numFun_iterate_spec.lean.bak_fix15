-- Generated from ChapterHermiteGraphApprox.lean — solution of BookProof.HermiteGraphApprox.numFun_iterate_spec
import Mathlib
import Definitions.Def_ChapterHermiteGraphApprox
import Theorems.Thm_BookProof_HermiteGraphApprox_contDiff_Lfun
import Theorems.Thm_BookProof_HermiteGraphApprox_hasCompactSupport_Lfun
import Theorems.Thm_BookProof_DegSchrodinger_contDiff_polyW
open BookProof.HermiteGraphApprox




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.DegEnergy BookProof.HermiteLadder
open BookProof.ConvolutionCalc
open scoped ENNReal

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) {g : Vd d → ℂ} (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g)
    (hgc : HasCompactSupport g) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) ((numFun d)^[k] g) ∧
      HasCompactSupport ((numFun d)^[k] g) := by

  induction k with
  | zero => exact ⟨hg, hgc⟩
  | succ k ih =>
      rw [Function.iterate_succ_apply']
      exact ⟨contDiff_Lfun _ (contDiff_polyW _) ih.1, hasCompactSupport_Lfun _ _ ih.2⟩
