-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.ccHamS_esa
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_deficiencyTrivialAt_ccHamS
open BookProof.DegKatoEsa




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (hW1 : ∀ x, 1 ≤ W x) (S : Finset (Fin d)) :
    EssentiallySelfAdjointOn (ccDomain (Vd d)) (ccHamS W hWs S) :=
  ⟨deficiencyTrivialAt_ccHamS W hWs hW1 S (by simp),
     deficiencyTrivialAt_ccHamS W hWs hW1 S (by simp)⟩
