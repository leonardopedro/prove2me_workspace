-- Generated from ChapterQgHermiteFriedrichs.lean — theorem BookProof.QgHermiteFriedrichs.hamCore_pgLp
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterFriedrichsExtension
import Mathlib
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQgHermiteCore
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QgHermiteCore
open BookProof.QgHermiteFriedrichs



open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.Starobinsky
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.FriedrichsExtension

noncomputable section

variable {d : ℕ}

variable (W : Vd d → ℝ)

theorem BookProof.QgHermiteFriedrichs.hamCore_pgLp (hWc : Continuous W) (hWb : ExpBounded W) (p : MvPolynomial (Fin d) ℂ) :
    hamCore W hWc hWb ⟨pgLp p, pgLp_mem_core p⟩ = hamPoly W hWc hWb p := by sorry
