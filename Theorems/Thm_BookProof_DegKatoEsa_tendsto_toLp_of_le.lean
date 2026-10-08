-- Generated from ChapterDegKatoEsa.lean — theorem BookProof.DegKatoEsa.tendsto_toLp_of_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterConvolutionCalc
import Definitions.Def_ChapterDegEnergyEstimate
import Definitions.Def_ChapterMollifierL2
import Mathlib
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.HermiteProductCore
open BookProof.DegKatoEsa



open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section

variable {d : ℕ}


theorem BookProof.DegKatoEsa.tendsto_toLp_of_le {f : ℕ → Vd d → ℂ} {g : Vd d → ℂ}
    (hf : ∀ n, MemLp (f n) 2 (volume : Measure (Vd d))) (hg : MemLp g 2 (volume : Measure (Vd d)))
    {e : ℕ → ENNReal} (he : Tendsto e atTop (𝓝 0)) (B : ℝ)
    (hle : ∀ n, eLpNorm (f n - g) 2 (volume : Measure (Vd d)) ≤ ENNReal.ofReal B * e n) :
    Tendsto (fun n => (hf n).toLp (f n)) atTop (𝓝 (hg.toLp g)) := by sorry
