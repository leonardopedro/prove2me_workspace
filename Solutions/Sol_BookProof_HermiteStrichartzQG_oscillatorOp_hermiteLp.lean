-- Generated from ChapterStrichartzHermiteQG.lean — solution of BookProof.HermiteStrichartzQG.oscillatorOp_hermiteLp
import Mathlib
import Definitions.Def_ChapterStrichartzHermiteQG
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_hermiteLp
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQuantumGravityDensitized
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteLp_mem_hermiteCore
open BookProof.HermiteStrichartzQG




open MeasureTheory BookProof.HermiteCore BookProof.FarisLavine
open BookProof.QuantumGravityDensitized
open BookProof.HermiteCore

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    hermiteCoreOp oscillatorSymbol ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = (((n : ℝ) + 1 / 2 : ℝ) : ℂ) • hermiteLp n := hermiteCoreOp_hermiteLp oscillatorSymbol n
