-- Generated from ChapterStrichartzHermiteQG.lean — theorem BookProof.HermiteStrichartzQG.qg3D_not_bounded
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterA4
open BookProof.QuantumGravityDensitized



open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

theorem BookProof.HermiteStrichartzQG.qg3D_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : hermiteCore,
      ‖qg3DHermiteHamiltonian (fun k _ => (k : ℝ)) 0 0 f‖ ≤ C * ‖(f : L2R)‖ := by sorry
