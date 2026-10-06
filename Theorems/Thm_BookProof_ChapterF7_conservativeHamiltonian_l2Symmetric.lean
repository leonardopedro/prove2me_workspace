-- Generated from ChapterF7.lean — theorem BookProof.ChapterF7.conservativeHamiltonian_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
open BookProof.ChapterF7


open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

theorem BookProof.ChapterF7.conservativeHamiltonian_l2Symmetric (V : ℝ → ℝ)
    (hV : Function.HasTemperateGrowth (fun x => (V x : ℂ))) :
    IsL2Symmetric (Complex.I • (kinetic.comp (mulOp V hV) - (mulOp V hV).comp kinetic)) := by sorry
