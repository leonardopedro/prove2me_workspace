-- Generated from ChapterStrichartzHermiteQG.lean — theorem BookProof.HermiteStrichartzQG.hermiteCoreOp_hermiteLp
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

theorem BookProof.HermiteStrichartzQG.hermiteCoreOp_hermiteLp (lam : ℕ → ℝ) (n : ℕ) :
    hermiteCoreOp lam ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = ((lam n : ℂ)) • hermiteLp n := by sorry
