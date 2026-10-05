-- Generated from ChapterConvolutionCalc.lean — theorem BookProof.ConvolutionCalc.integrable_cnv_integrand
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


theorem BookProof.ConvolutionCalc.integrable_cnv_integrand {u g : Vd d → ℂ}
    (hu : LocallyIntegrable u (volume : Measure (Vd d))) (hg : Continuous g)
    (hgc : HasCompactSupport g) (x : Vd d) :
    Integrable (fun y => u y * g (x - y)) (volume : Measure (Vd d)) := by sorry
