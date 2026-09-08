-- Generated from ChapterBaryonAsymmetry.lean — theorem BookProof.ChapterBaryonAsymmetry.radiation_satisfies_continuity
import Mathlib
import Definitions.Def_ChapterBaryonAsymmetry
open BookProof.ChapterBaryonAsymmetry












open Filter Topology

theorem BookProof.ChapterBaryonAsymmetry.radiation_satisfies_continuity (ρr0 a : ℝ) (ha : 0 < a) :
    a * deriv (fun x => radDensity ρr0 x) a + 3 * (1 + 1/3) * radDensity ρr0 a = 0 := by sorry
