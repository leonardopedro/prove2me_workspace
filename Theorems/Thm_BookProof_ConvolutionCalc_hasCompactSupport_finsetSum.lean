-- Generated from ChapterConvolutionCalc.lean — theorem BookProof.ConvolutionCalc.hasCompactSupport_finsetSum
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


theorem BookProof.ConvolutionCalc.hasCompactSupport_finsetSum {ι : Type*} (s : Finset ι) {f : ι → Vd d → ℂ}
    (h : ∀ i ∈ s, HasCompactSupport (f i)) : HasCompactSupport (fun x => ∑ i ∈ s, f i x) := by sorry
