-- Generated from ChapterStoneConverse.lean — solution of BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup.genOp_bAvg
import Mathlib
import Definitions.Def_ChapterStoneConverse
import Theorems.Thm_BookProof_ChapterStoneMeasurable_WeakMeasurableUnitaryGroup_apply_zero
open BookProof.ChapterStoneMeasurable
open BookProof.ChapterStoneMeasurable.WeakMeasurableUnitaryGroup



open scoped InnerProductSpace
open Filter Topology MeasureTheory


variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H]

set_option maxHeartbeats 1000000 in
theorem solution (x : H) (a : ℝ) :
    G.genOp ⟨G.bAvg x a, G.bAvg_mem_genDomain x a⟩ = Complex.I • (G.U a x - x) := by

  rw [genOp_apply]
  congr 1
  have h : (fun s : ℝ => G.U s (G.bAvg x a))
      = fun s : ℝ => G.bAvg x (s + a) - G.bAvg x s := by
    funext s; exact G.apply_bAvg s a x
  have hfa : HasDerivAt (fun u : ℝ => G.bAvg x u) (G.U a x) (0 + a) := by
    simpa using G.hasDerivAt_bAvg x a
  have h1 : HasDerivAt (fun s : ℝ => G.bAvg x (s + a)) (G.U a x) 0 :=
    HasDerivAt.comp_add_const 0 a hfa
  have h2 : HasDerivAt (fun s : ℝ => G.bAvg x s) (G.U 0 x) 0 := G.hasDerivAt_bAvg x 0
  have := (h1.sub h2)
  simp only [G.apply_zero] at this
  rw [show (fun s : ℝ => G.U s (G.bAvg x a)) = fun s : ℝ => G.bAvg x (s + a) - G.bAvg x s from h]
  exact this.deriv
