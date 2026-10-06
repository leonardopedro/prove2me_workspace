-- Generated from ChapterF7.lean — solution of BookProof.ChapterF7.conservativeHamiltonian_l2Symmetric
import Mathlib
import Definitions.Def_ChapterF7
import Theorems.Thm_BookProof_ChapterF7_mulOp_l2Symmetric
import Theorems.Thm_BookProof_ChapterF7_i_comm_l2Symmetric
import Theorems.Thm_BookProof_ChapterF7_kinetic_l2Symmetric
open BookProof.ChapterF7



open SchwartzMap MeasureTheory Complex
open scoped BigOperators


noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (V : ℝ → ℝ)
    (hV : Function.HasTemperateGrowth (fun x => (V x : ℂ))) :
    IsL2Symmetric (Complex.I • (kinetic.comp (mulOp V hV) - (mulOp V hV).comp kinetic)) := i_comm_l2Symmetric kinetic_l2Symmetric (mulOp_l2Symmetric V hV)
