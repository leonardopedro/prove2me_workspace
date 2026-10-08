-- Generated from ChapterDegSchrodingerCore.lean — theorem BookProof.DegSchrodinger.hamCoreS_coeFn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.QgHermiteFriedrichs
open BookProof.DegSchrodinger



open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}


theorem BookProof.DegSchrodinger.hamCoreS_coeFn (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W)
    (S : Finset (Fin d)) (p : MvPolynomial (Fin d) ℂ) :
    ((hamCoreS W hWc hWb S ⟨pgLp p, pgLp_mem_core p⟩ : L2d d) : Vd d → ℂ)
      =ᵐ[volume] fun z => pgFun (kinPolyS S p) z + ((W z : ℝ) : ℂ) * pgFun p z := by sorry
