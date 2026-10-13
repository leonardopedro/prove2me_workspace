-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.memLp_majorant
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgHermiteCore_memLp_mul_pgFun_of_expBounded
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
theorem solution (W : Vd d → ℝ) (hWc : Continuous W) (hWb : ExpBounded W) (K : ℝ)
    (p : MvPolynomial (Fin d) ℂ) :
    MemLp (majorant W K p) 2 (volume : Measure (Vd d)) := by

  have h1 : MemLp (fun z : Vd d => ‖pgFun (kinPoly p) z‖) 2 (volume : Measure (Vd d)) :=
    (memLp_pgFun (kinPoly p)).norm
  have h2 : MemLp (fun z : Vd d => K * ‖pgFun p z‖) 2 (volume : Measure (Vd d)) :=
    (memLp_pgFun p).norm.const_mul K
  have h3 : MemLp (fun z : Vd d => ∑ j : Fin d, ‖pgFun (coreD j p) z‖) 2
      (volume : Measure (Vd d)) := by
    have h := memLp_finset_sum' (μ := (volume : Measure (Vd d))) (p := 2)
      (Finset.univ : Finset (Fin d))
      (f := fun (j : Fin d) (z : Vd d) => ‖pgFun (coreD j p) z‖)
      (fun j _ => (memLp_pgFun (coreD j p)).norm)
    have heq : (fun z : Vd d => ∑ j : Fin d, ‖pgFun (coreD j p) z‖)
        = ∑ j : Fin d, (fun z : Vd d => ‖pgFun (coreD j p) z‖) := by
      funext z
      simp
    rw [heq]
    exact h
  have h4 : MemLp (fun z : Vd d => ‖((W z : ℝ) : ℂ) * pgFun p z‖) 2
      (volume : Measure (Vd d)) := (memLp_mul_pgFun_of_expBounded hWc hWb p).norm
  exact ((h1.add h2).add (h3.const_mul (2 * K))).add h4
