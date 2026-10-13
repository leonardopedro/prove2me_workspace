-- Generated from ChapterDegKatoEsa.lean — solution of BookProof.DegKatoEsa.deficiencyTrivialAt_ccHamS
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Theorems.Thm_BookProof_DegKatoEsa_norm_le_cut_tail
import Theorems.Thm_BookProof_QgOneParticleCc_exists_cut_derivative_bounds
import Theorems.Thm_BookProof_QgOneParticleCc_tendsto_tailNorm
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterMollifierL2
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.DegKatoEsa




open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ)
    (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W) (hW1 : ∀ x, 1 ≤ W x) (S : Finset (Fin d))
    {z : ℂ} (hz : z.re = 0) :
    DeficiencyTrivialAt (ccDomain (Vd d)) (ccHamS W hWs S) z := by

  intro u hu
  obtain ⟨C, hC0, hCb⟩ := exists_cut_derivative_bounds d
  have hlim : Tendsto (fun N : ℕ => Real.sqrt (2 * S.card) * (C / N) * ‖u‖
      + (eLpNorm (({z : Vd d | ‖z‖ ≤ (N : ℝ)}ᶜ).indicator (fun x => ‖(u : Vd d → ℂ) x‖)) 2
          (volume : Measure (Vd d))).toReal) atTop (𝓝 0) := by
    have h1 : Tendsto (fun N : ℕ => Real.sqrt (2 * S.card) * (C / N) * ‖u‖) atTop (𝓝 0) := by
      have := ((tendsto_const_div_atTop_nhds_zero_nat C).const_mul
        (Real.sqrt (2 * S.card))).mul_const ‖u‖
      simpa using this
    simpa using h1.add (tendsto_tailNorm (Lp.memLp u).norm)
  have hle : ‖u‖ ≤ 0 := ge_of_tendsto hlim (eventually_atTop.2 ⟨1, fun N hN =>
    norm_le_cut_tail W hWs hW1 S hz hu hC0 hN fun j x => (hCb N (by exact_mod_cast hN) x).1 j⟩)
  exact norm_le_zero_iff.1 hle
