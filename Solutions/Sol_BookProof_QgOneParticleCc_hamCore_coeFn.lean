-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.hamCore_coeFn
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgHermiteFriedrichs_hamCore_pgLp
import Theorems.Thm_BookProof_QgHermiteFriedrichs_potLp_coeFn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.QgHermiteFriedrichs

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W)
    (p : MvPolynomial (Fin d) ℂ) :
    ((hamCore W hWc hWb ⟨pgLp p, pgLp_mem_core p⟩ : L2d d) : Vd d → ℂ)
      =ᵐ[volume] fun z => pgFun (kinPoly p) z + ((W z : ℝ) : ℂ) * pgFun p z := by

  rw [hamCore_pgLp]
  simp only [hamPoly]
  filter_upwards [Lp.coeFn_add (pgLp (kinPoly p)) (potLp W hWc hWb p), pgLp_coeFn (kinPoly p),
    potLp_coeFn W hWc hWb p] with z hz h2 h3
  rw [hz, Pi.add_apply, h2, h3]
