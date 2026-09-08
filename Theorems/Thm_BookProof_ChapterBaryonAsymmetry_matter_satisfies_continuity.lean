-- Generated from ChapterBaryonAsymmetry.lean — theorem BookProof.ChapterBaryonAsymmetry.matter_satisfies_continuity
import Mathlib
import Definitions.Def_ChapterBaryonAsymmetry
open BookProof.ChapterBaryonAsymmetry












open Filter Topology

theorem BookProof.ChapterBaryonAsymmetry.matter_satisfies_continuity (ρm0 a : ℝ) (ha : 0 < a) :
    a * deriv (fun x => matterDensity ρm0 x) a + 3 * (1 + 0) * matterDensity ρm0 a = 0 := by sorry
