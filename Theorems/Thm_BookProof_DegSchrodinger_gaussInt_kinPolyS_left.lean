-- Generated from ChapterDegSchrodingerCore.lean — theorem BookProof.DegSchrodinger.gaussInt_kinPolyS_left
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.DegSchrodinger

variable {d : ℕ}



open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs

noncomputable section


theorem BookProof.DegSchrodinger.gaussInt_kinPolyS_left (S : Finset (Fin d)) (p q : MvPolynomial (Fin d) ℂ) :
    gaussInt (cpoly (kinPolyS S p) * q)
      = ∑ j ∈ S, gaussInt (cpoly (coreD j p) * coreD j q) := by sorry
