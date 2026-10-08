-- Generated from ChapterConvolutionCalc.lean — theorem BookProof.ConvolutionCalc.lapCS_cnv
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


theorem BookProof.ConvolutionCalc.lapCS_cnv {u ρ : Vd d → ℂ} (hu : LocallyIntegrable u (volume : Measure (Vd d)))
    (hρ : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) ρ) (hc : HasCompactSupport ρ)
    (S : Finset (Fin d)) (x : Vd d) :
    lapCS S (cnv u ρ) x = cnv u (lapCS S ρ) x := by sorry
