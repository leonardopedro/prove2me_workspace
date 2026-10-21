-- Generated from ChapterConvolutionCalc.lean — solution of BookProof.ConvolutionCalc.integrable_cnv_integrand
import Mathlib
import Definitions.Def_ChapterConvolutionCalc
open BookProof.ConvolutionCalc




open MeasureTheory
open BookProof.HermiteProductCore BookProof.QgOneParticleCc BookProof.DegSchrodinger

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {u g : Vd d → ℂ}
    (hu : LocallyIntegrable u (volume : Measure (Vd d))) (hg : Continuous g)
    (hgc : HasCompactSupport g) (x : Vd d) :
    Integrable (fun y => u y * g (x - y)) (volume : Measure (Vd d)) := hgc.convolutionExists_right (ContinuousLinearMap.mul ℝ ℂ) hu hg x
