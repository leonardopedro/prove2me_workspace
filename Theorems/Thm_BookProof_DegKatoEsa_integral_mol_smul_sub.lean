-- Generated from ChapterDegKatoEsa.lean — theorem BookProof.DegKatoEsa.integral_mol_smul_sub
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

variable {d : ℕ}



open MeasureTheory SchwartzMap MvPolynomial Filter Topology
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.DegSchrodinger
open BookProof.ConvolutionCalc BookProof.DegEnergy BookProof.MollifierL2

noncomputable section


theorem BookProof.DegKatoEsa.integral_mol_smul_sub {f : Vd d → ℂ} (hf : LocallyIntegrable f (volume : Measure (Vd d)))
    (n : ℕ) (x : Vd d) :
    ∫ y, mol d n y • (f (x - y) - f x) = cnv f (cx (mol d n)) x - f x := by sorry
