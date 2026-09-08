-- Generated from ChapterBaryonAsymmetry.lean — theorem BookProof.ChapterBaryonAsymmetry.matterRadiationRatio_strictMonoOn
import Mathlib
import Definitions.Def_ChapterBaryonAsymmetry
open BookProof.ChapterBaryonAsymmetry












open Filter Topology

theorem BookProof.ChapterBaryonAsymmetry.matterRadiationRatio_strictMonoOn (ρm0 ρr0 : ℝ) (hm : 0 < ρm0) (hr : 0 < ρr0) :
    StrictMonoOn (fun a => matterRadiationRatio ρm0 ρr0 a) (Set.Ioi (0 : ℝ)) := by sorry
