-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.hamCoreS_pgLp
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Theorems.Thm_BookProof_QgHermiteFriedrichs_coreEquiv_symm_pgLp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductBasis
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterNavierStokesDifferentialL2
import Definitions.Def_ChapterQgHermiteCore
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis
open BookProof.HermiteProductCore
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.QgHermiteCore

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W)
    (S : Finset (Fin d)) (p : MvPolynomial (Fin d) ℂ) :
    hamCoreS W hWc hWb S ⟨pgLp p, pgLp_mem_core p⟩ = hamPolyS W hWc hWb S p := by

  simp only [hamCoreS, LinearMap.comp_apply, LinearEquiv.coe_coe, coreEquiv_symm_pgLp]
  rfl
