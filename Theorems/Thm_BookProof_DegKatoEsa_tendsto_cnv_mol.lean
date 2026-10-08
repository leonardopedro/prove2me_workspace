-- Generated from ChapterDegKatoEsa.lean — theorem BookProof.DegKatoEsa.tendsto_cnv_mol
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


theorem BookProof.DegKatoEsa.tendsto_cnv_mol {f : Vd d → ℂ} (hf : StronglyMeasurable f)
    (hf2 : MemLp f 2 (volume : Measure (Vd d))) :
    Tendsto (fun n : ℕ => eLpNorm (fun x => cnv f (cx (mol d n)) x - f x) 2 volume) atTop
      (𝓝 0) := by sorry
