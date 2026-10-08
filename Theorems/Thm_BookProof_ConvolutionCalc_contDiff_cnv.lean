-- Generated from ChapterConvolutionCalc.lean — theorem BookProof.ConvolutionCalc.contDiff_cnv
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.ConvolutionCalc



open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}


theorem BookProof.ConvolutionCalc.contDiff_cnv {u ρ : Vd d → ℂ} (hu : LocallyIntegrable u (volume : Measure (Vd d)))
    (hρ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) ρ) (hc : HasCompactSupport ρ) :
    ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) (cnv u ρ) := by sorry
