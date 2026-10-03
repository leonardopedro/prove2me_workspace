-- Generated from ChapterStrichartzHermiteQG.lean — theorem BookProof.HermiteStrichartzQG.inner_hermiteLp_eq_zero_iff
import Definitions.Def_ChapterQuantumGravityDensitized
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterA4
open BookProof.FarisLavine
open BookProof.HermiteCore



open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized

theorem BookProof.HermiteStrichartzQG.inner_hermiteLp_eq_zero_iff {w : L2R} :
    (∀ n : ℕ, (inner ℂ (hermiteLp n) w : ℂ) = 0) ↔ w = 0 := by sorry
