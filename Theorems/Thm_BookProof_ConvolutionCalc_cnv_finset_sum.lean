-- Generated from ChapterConvolutionCalc.lean — theorem BookProof.ConvolutionCalc.cnv_finset_sum
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.ConvolutionCalc

variable {d : ℕ}



open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section


theorem BookProof.ConvolutionCalc.cnv_finset_sum {ι : Type*} (s : Finset ι) {u : Vd d → ℂ} {g : ι → Vd d → ℂ}
    (hu : LocallyIntegrable u (volume : Measure (Vd d)))
    (hg : ∀ i ∈ s, Continuous (g i)) (hgc : ∀ i ∈ s, HasCompactSupport (g i)) (x : Vd d) :
    cnv u (fun y => ∑ i ∈ s, g i y) x = ∑ i ∈ s, cnv u (g i) x := by sorry
