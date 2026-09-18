-- Generated from ChapterH6.lean — theorem BookProof.ChapterH6.sirk_error_bound_antitone
import Mathlib
import Definitions.Def_ChapterH6
open BookProof.ChapterH6


noncomputable section

open Filter Topology

theorem BookProof.ChapterH6.sirk_error_bound_antitone (C Dmin h nv : ℝ)
    (hC : 0 ≤ C) (hD : 0 ≤ Dmin) (hnv : 0 ≤ nv) (hh : 0 ≤ h) :
    Antitone (fun m : ℕ => sirkBound C Dmin h nv m) := by sorry
