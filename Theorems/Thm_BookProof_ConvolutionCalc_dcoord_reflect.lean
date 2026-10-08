-- Generated from ChapterConvolutionCalc.lean — theorem BookProof.ConvolutionCalc.dcoord_reflect
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


theorem BookProof.ConvolutionCalc.dcoord_reflect {g : Vd d → ℂ} (hg : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) g) (x : Vd d)
    (j : Fin d) : dcoord j (fun y => g (x - y)) = fun y => -(dcoord j g (x - y)) := by sorry
